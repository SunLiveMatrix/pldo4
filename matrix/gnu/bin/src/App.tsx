import {
    Button,
    Card,
    Form,
    Icon,
    Image,
    Label,
    List,
    Menu,
    Progress,
    Segment,
} from 'semantic-ui-react';
import styles from './App.module.scss';

function App() {
    return (
        <div className={styles.page}>
            <div>
                <h1 className={styles.title}>Semantic UI Is Great</h1>
                <p className={styles.description}>
                    With Semantic UI, you can create beautiful websites using human-friendly HTML
                    and intuitive javascript. <br />
                    It’s the ultimate web design tool!
                </p>
                <div className={styles.actions}>
                    <Button color="black">Read Article</Button>
                    <Button basic color="black">
                        Documentation
                    </Button>
                </div>
            </div>
            <div>
                <div className={styles.labels}>
                    <Label color="pink" tag>
                        New
                    </Label>
                    <Label color="purple" tag>
                        Upcoming
                    </Label>
                    <Label color="violet" tag>
                        Featured
                    </Label>
                </div>
                <div className={styles['two-columns']}>
                    <Segment attached color="teal">
                        <Label color="teal" ribbon content="Hotel" icon="hotel" />
                        <div>Account Details</div>
                        <Image src="https://react.semantic-ui.com/images/wireframe/paragraph.png" />
                    </Segment>

                    <Segment attached color="olive">
                        <Label color="olive" ribbon="right" content="Overview" />
                        <div>Account Details</div>
                        <Image src="https://react.semantic-ui.com/images/wireframe/paragraph.png" />
                    </Segment>
                </div>
                <div className={styles['two-columns']}>
                    <div className={styles['profile-img']}>
                        <Image
                            src="https://semantic-ui.com/images/avatar2/small/molly.png"
                            size="small"
                            circular
                            bordered={true}
                        />
                    </div>
                    <List floated="right">
                        <List.Item icon="users" content="Semantic UI" />
                        <List.Item icon="marker" content="New York, NY" />
                        <List.Item
                            icon="mail"
                            content={<a href="mailto:jack@semantic-ui.com">jack@semantic-ui.com</a>}
                        />
                        <List.Item
                            icon="linkify"
                            content={<a href="http://www.semantic-ui.com">semantic-ui.com</a>}
                        />
                    </List>
                </div>
            </div>
            <div>
                <Card fluid={true} color="violet">
                    <Image
                        fluid={true}
                        centered={true}
                        src="https://react.semantic-ui.com/images/avatar/large/matthew.png"
                        wrapped
                        ui={true}
                    />
                    <Card.Content>
                        <Card.Header>Matthew</Card.Header>
                        <Card.Meta>Joined in 2015</Card.Meta>
                    </Card.Content>
                    <Card.Content extra={true}>
                        <a>
                            <Icon name="user" />
                            22 Friends
                        </a>
                    </Card.Content>
                </Card>
            </div>
            <div className={styles['button-showcase']}>
                <div className={styles['buttons-row']}>
                    <Button.Group
                        buttons={[
                            { key: 'align left', icon: 'align left' },
                            { key: 'align center', icon: 'align center' },
                            { key: 'align right', icon: 'align right' },
                            { key: 'align justify', icon: 'align justify' },
                        ]}
                    />
                    <Button.Group
                        buttons={[
                            { key: 'align left', icon: 'bold' },
                            { key: 'align center', icon: 'underline' },
                            { key: 'align right', icon: 'text width' },
                        ]}
                    />
                </div>
                <div className={styles['buttons-row']}>
                    <Button animated>
                        <Button.Content visible>Next</Button.Content>
                        <Button.Content hidden>
                            <Icon name="arrow right" />
                        </Button.Content>
                    </Button>
                    <Button animated="vertical">
                        <Button.Content hidden>Shop</Button.Content>
                        <Button.Content visible>
                            <Icon name="shop" />
                        </Button.Content>
                    </Button>
                    <Button animated="fade">
                        <Button.Content visible>Sign-up for a Pro account</Button.Content>
                        <Button.Content hidden>$12.99 a month</Button.Content>
                    </Button>
                </div>
                <div className={styles['buttons-row']}>
                    <Label image>
                        <img src="https://react.semantic-ui.com/images/avatar/small/christian.jpg" />
                        Christian
                        <Icon name="delete" />
                    </Label>
                    <Label image>
                        <img src="https://react.semantic-ui.com/images/avatar/small/elliot.jpg" />
                        Elliot
                        <Icon name="delete" />
                    </Label>
                    <Label image>
                        <img src="https://react.semantic-ui.com/images/avatar/small/zoe.jpg" />
                        Zoe
                        <Icon name="delete" />
                    </Label>
                </div>
                <div className={styles['buttons-row']}>
                    <Label as="a" color="blue" image>
                        <img src="https://react.semantic-ui.com/images/avatar/small/nan.jpg" />
                        Veronika
                        <Label.Detail>Bff</Label.Detail>
                    </Label>
                    <Label as="a" color="teal" image>
                        <img src="https://react.semantic-ui.com/images/avatar/small/jenny.jpg" />
                        Jenny
                        <Label.Detail>Friend</Label.Detail>
                    </Label>
                    <Label as="a" color="yellow" image>
                        <img src="https://react.semantic-ui.com/images/avatar/small/joe.jpg" />
                        Joe<Label.Detail>Co-worker</Label.Detail>
                    </Label>
                </div>
                <div className={styles['buttons-row']}>
                    <Menu compact>
                        <Menu.Item as="a">
                            <Icon name="mail" /> Messages
                            <Label color="red" floating>
                                22
                            </Label>
                        </Menu.Item>
                        <Menu.Item as="a">
                            <Icon name="users" /> Friends
                            <Label color="teal" floating>
                                24
                            </Label>
                        </Menu.Item>
                    </Menu>
                    <div>
                        <Button as="div" labelPosition="right">
                            <Button color="red">
                                <Icon name="heart" />
                                Like
                            </Button>
                            <Label basic color="red" pointing="left">
                                27,804
                            </Label>
                        </Button>
                    </div>
                </div>
            </div>
            <div className={styles['utils-showcase']}>
                <Form>
                    <Form.Field inline={false} className={styles['name-input']}>
                        <input type="text" placeholder="Username" />
                        <Label pointing="left" color="blue" size="medium" as="span">
                            That name is taken!
                        </Label>
                    </Form.Field>
                </Form>
                <Progress percent={25} indicating={false} color="grey" />
                <div className={styles.wireframes}>
                    <Image
                        label={{ corner: 'left', icon: 'close' }}
                        src="https://react.semantic-ui.com/images/wireframe/image.png"
                        className={styles['img-size']}
                        size="small"
                    />
                    <Image
                        label={{ color: 'red', corner: 'right', icon: 'heart' }}
                        src="https://react.semantic-ui.com/images/wireframe/image.png"
                        floated="right"
                        className={styles['img-size']}
                        size="small"
                    ></Image>
                </div>
            </div>
            <div className={styles['social-showcase']}>
                <Card fluid={true}>
                    <Card.Content>
                        <Image
                            floated="right"
                            size="mini"
                            src="https://semantic-ui.com/images/avatar2/small/molly.png"
                        />
                        <Card.Header>Molly Sanders</Card.Header>
                        <Card.Meta>Friends of Elliot</Card.Meta>
                        <Card.Description>
                            Steve is your <strong>best friend</strong>
                        </Card.Description>
                    </Card.Content>
                    <Card.Content extra>
                        <Button.Group>
                            <Button basic color="green">
                                Approve
                            </Button>
                            <Button basic color="red">
                                Decline
                            </Button>
                        </Button.Group>
                    </Card.Content>
                </Card>
                <div className={styles.icons}>
                    <Button icon color="facebook" circular={true}>
                        <Icon name="facebook" />
                    </Button>
                    <Button icon color="linkedin" circular={true}>
                        <Icon name="linkedin" />
                    </Button>
                    <Button icon color="twitter" circular={true}>
                        <Icon name="twitter" />
                    </Button>
                    <Button icon color="youtube" circular={true}>
                        <Icon name="youtube" />
                    </Button>
                </div>
                <div className={styles.buttons}>
                    <Button.Group>
                        <Button>Cancel</Button>
                        <Button.Or />
                        <Button positive>Save for later</Button>
                    </Button.Group>
                </div>
            </div>
        </div>
    );
}

export default App;
